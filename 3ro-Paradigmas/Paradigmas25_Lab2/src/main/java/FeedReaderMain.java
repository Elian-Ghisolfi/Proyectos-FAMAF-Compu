import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

import feed.Article;
import feed.Feed;
import namedEntity.NamedEntity;
import namedEntity.heuristic.Heuristic;
import namedEntity.heuristic.QuickHeuristic;
import namedEntity.heuristic.RandomHeuristic;
import parser.SubscriptionParser;
import subscription.SingleSubscription;

public class FeedReaderMain {
    
    private static void printHelp() {
        System.out.println("Please, call this program in correct way: FeedReader [-ne]");
    }

    public static Feed selectSourceMenu(List<SingleSubscription> mySubscriptions, Scanner scanner) {
        int fuente = -1;
        Feed selectedFeed = null;
        
        while (selectedFeed == null) {
            System.out.println("\n--- ELIJA QUE PAGINA DESEA VISITAR ---");
            System.out.println("1. New York Times");
            System.out.println("2. Reddit");
            System.out.println("0. Salir\n");
            System.out.print("Seleccione una opción: ");
            
            try {
                fuente = scanner.nextInt();
                
                switch(fuente) {
                    case 1:
                        selectedFeed = FeedManager.getRssFeed(mySubscriptions);
                        if (selectedFeed == null) {
                            System.out.println("No se encontraron feeds RSS disponibles.");
                        }
                        break;
                    case 2:
                        selectedFeed = FeedManager.getRedditFeed(mySubscriptions);
                        if (selectedFeed == null) {
                            System.out.println("No se encontraron feeds Reddit disponibles.");
                        }
                        break;
                    case 0:
                        System.out.println("Saliendo del programa...");
                        scanner.close();
                        System.exit(0);
                    default:
                        System.out.println("Opción no válida. Intente nuevamente.");
                }
            } catch (InputMismatchException e) {
                System.out.println("Error: Debe ingresar un número.");
                scanner.next(); // Limpiar el buffer
            }
        }
        
        return selectedFeed;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        /* Parseamos el archivo JSON */
        SubscriptionParser newSubscription = new SubscriptionParser();
        List<SingleSubscription> mySubscriptions = newSubscription.ParseJSON();

        if (args.length == 0) {
            System.out.println("***** FeedReader version 2.0 *****");
            Feed myFeed = selectSourceMenu(mySubscriptions, scanner);
            
            if (myFeed != null) {
                myFeed.prettyPrint();
            }
        } 
        else if (args.length == 1 && args[0].equals("-ne")) {
            System.out.println("***** FeedReader version 2.0 - Named Entity Recognition *****");
            Feed selectedFeed = selectSourceMenu(mySubscriptions, scanner);
            
            // Menú para seleccionar heurística
            Heuristic heuristic = null;
            while (heuristic == null) {
                System.out.println("\n--- SELECCIONE LA HEURÍSTICA ---");
                System.out.println("1. Quick Heuristic");
                System.out.println("2. Random Heuristic");
                System.out.println("0. Salir\n");
                System.out.print("Seleccione una opción: ");
                
                try {
                    int opcionHeuristica = scanner.nextInt();
                    
                    switch(opcionHeuristica) {
                        case 1:
                            heuristic = new QuickHeuristic();
                            System.out.println("Heurística Quick seleccionada.");
                            break;
                        case 2:
                            heuristic = new RandomHeuristic();
                            System.out.println("Heurística Random seleccionada.");
                            break;
                        case 0:
                            System.out.println("Saliendo del programa...");
                            scanner.close();
                            System.exit(0);
                        default:
                            System.out.println("Opción no válida. Intente nuevamente.");
                    }
                } catch (InputMismatchException e) {
                    System.out.println("Error: Debe ingresar un número.");
                    scanner.next(); // Limpiar el buffer
                }
            }

            // Procesar las entidades nombradas
            System.out.println("\nProcesando entidades nombradas...");
            System.out.println("=== Feed: " + selectedFeed.getSiteName() + " ===");
            
            for (int i = 0; i < selectedFeed.getNumberOfArticles(); i++) {
                Article art = selectedFeed.getArticle(i);
                art.computeNamedEntities(heuristic);
                
                System.out.println("\n--- Artículo: '" + art.getTitle() + "' ---");
                boolean foundEntities = false;
                
                // Analizar tanto el título como el texto del artículo
                String[] textsToAnalyze = {art.getTitle(), art.getText()};
                for (String text : textsToAnalyze) {
                    if (text != null && !text.isEmpty()) {
                        for (String word : text.split("\\s+")) {
                            NamedEntity ne = art.getNamedEntity(word);
                            if (ne != null && !ne.getCategory().equals("Unknow")) {
                                ne.prettyPrint();
                                foundEntities = true;
                            }
                        }
                    }
                }
                
                if (!foundEntities) {
                    System.out.println("No se encontraron entidades nombradas en este artículo.");
                }
            }
            
            System.out.println("\nAnálisis de entidades nombradas completado.");
        }
        else {
            printHelp();
        }
        
        scanner.close();
    }
}