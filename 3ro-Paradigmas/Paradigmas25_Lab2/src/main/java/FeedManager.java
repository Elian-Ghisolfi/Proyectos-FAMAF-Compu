import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;
import java.util.stream.Collectors;

import feed.Feed;
import parser.RedditParser;
import parser.RssParser;
import subscription.SingleSubscription;

public class FeedManager {
    
    // Enums para tipos de feed (opcional pero recomendado)
    public enum FeedType {
        RSS, REDDIT
    }

    // Interfaz funcional para los parsers
    @FunctionalInterface
    public interface FeedParser {
        Feed parse(String url, String param) throws Exception;
    }

    // Método genérico principal
    public static Feed getFeedByType(List<SingleSubscription> subscriptions, FeedType type) {
        // Configuración específica por tipo
        String typeString = type.name().toLowerCase();
        FeedParser parser = type == FeedType.RSS 
            ? (url, param) -> new RssParser().ParseXML(url, param)
            : (url, param) -> new RedditParser().ParseReddit(url, param);

        // Filtrar suscripciones por tipo
        List<SingleSubscription> filteredSubs = subscriptions.stream()
            .filter(sub -> typeString.equals(sub.getUrlType()))
            .collect(Collectors.toList());

        if (filteredSubs.isEmpty()) {
            System.err.println("No hay suscripciones de " + typeString + " disponibles.");
            return new Feed(null);
        }

        // Recopilar parámetros y URLs
        List<String> allParams = new ArrayList<>();
        List<String> associatedUrls = new ArrayList<>();

        for (SingleSubscription sub : filteredSubs) {
            for (String param : sub.getUlrParams()) {
                allParams.add(param);
                associatedUrls.add(sub.getUrl());
            }
        }

        // Mostrar menú
        System.out.println("\n--- ELIJA QUE FEED DESEA OBTENER (" + typeString.toUpperCase() + ") ---");
        for (int i = 0; i < allParams.size(); i++) {
            System.out.println((i + 1) + ". " + allParams.get(i));
        }
        System.out.println("0. Volver atras\n");

        // Leer selección
        int choice = getMenuChoice(allParams.size());

        if (choice == 0) {
            System.out.println("Volviendo...");
            return null;
        }

        // Obtener y parsear feed seleccionado
        String selectedUrl = associatedUrls.get(choice - 1);
        String selectedParam = allParams.get(choice - 1);

        try {
            return parser.parse(selectedUrl, selectedParam);
        } catch (Exception e) {
            e.printStackTrace();
            return new Feed(null);
        }
    }

    // Métodos específicos (ahora son wrappers simples)
    public static Feed getRssFeed(List<SingleSubscription> subscriptions) {
        return getFeedByType(subscriptions, FeedType.RSS);
    }

    public static Feed getRedditFeed(List<SingleSubscription> subscriptions) {
        return getFeedByType(subscriptions, FeedType.REDDIT);
    }

    // Helper para leer selección del menú
    private static int getMenuChoice(int maxOptions) {
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.print("Seleccione una opción: ");
            try {
                int choice = scanner.nextInt();
                if (choice >= 0 && choice <= maxOptions) {
                    return choice;
                }
                System.out.println("Opción inválida. Intente de nuevo.");
            } catch (InputMismatchException e) {
                System.out.println("Entrada inválida. Introduzca un número.");
                scanner.next();
            }
        }
    }
}