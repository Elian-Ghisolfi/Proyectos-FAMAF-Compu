
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.spark.SparkConf;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.api.java.JavaSparkContext;
import org.apache.spark.sql.SparkSession;

import feed.Feed;
import httpRequest.httpRequester;
import namedEntity.NamedEntity;
import namedEntity.ProcessNamedEntity;
import namedEntity.heuristic.Heuristic;
import namedEntity.heuristic.QuickHeuristic;
import parser.RssParser;
import parser.SubscriptionParser;
import scala.Tuple2;
import subscription.SingleSubscription;

public class FeedReaderMain {

    private static void printHelp() {
        System.out.println("Please, call this program in correct way: FeedReader [-ne]");
    }

    private static List<String> getAllURL(List<SingleSubscription> subscriptions) {
        List<String> urls = new ArrayList<>();

        for (SingleSubscription subscription : subscriptions) {
            String baseUrl = subscription.getUrl();
            List<String> params = subscription.getUlrParams();

            if (params == null || params.isEmpty()) {
                // Si no hay parámetros, añadir la URL base tal cual
                urls.add(baseUrl);
            } else {
                // Si hay parámetros, insertarlos donde corresponda
                for (String param : params) {
                    String formattedUrl;
                    if (baseUrl.contains("%s")) {
                        // Si la URL contiene %s, usar String.format para insertar el parámetro
                        formattedUrl = String.format(baseUrl, param);
                    } else {
                        formattedUrl = baseUrl;
                    }
                    urls.add(formattedUrl);
                }
            }
        }
        return urls;
    }

    public static void main(String[] args) {

        if (args.length == 0) {

            System.out.println("************* FeedReader version 2.1 *************");

            SparkSession spark = SparkSession.builder() // Configura e inicia una sesión de Spark
                    .appName("lab03") // Nombre de la aplicación Spark
                    .master("local[*]") // Ejecuta en modo local utilizando todos los núcleos disponibles
                    .getOrCreate();                             // Crea o recupera la sesión de Spark existente

            JavaSparkContext jsc = new JavaSparkContext(spark.sparkContext()); // Inicializa el contexto de Spark para Java

            SubscriptionParser jsonParser = new SubscriptionParser();
            List<String> myUrls = getAllURL(jsonParser.ParseJSON());
            JavaRDD<String> urlsRDD = jsc.parallelize(myUrls, 5); // Paraleliza la lista en un RDD con 10 particiones

            JavaRDD<Feed> parsedFeedsRDD = urlsRDD.map(new UrlToFeedFunction());

            List<Feed> feeds = parsedFeedsRDD.collect();

            // Convertir feeds a un RDD
            JavaRDD<Feed> feedsRDD = jsc.parallelize(feeds, 5);

            // Procesar cada feed para obtener sus entidades
            JavaRDD<List<NamedEntity>> entitiesByFeedRDD = feedsRDD.map(new FeedToEntitiesFunction());

            // Recoger los resultados
            List<List<NamedEntity>> collectedEntities = entitiesByFeedRDD.collect();

            // Imprime todas las entidades recolectadas en el driver
            System.out.println("\n=== ENTIDADES NOMBRADAS PROCESADAS ===");
            if (collectedEntities.isEmpty()) {
                System.out.println("No se detectaron entidades nombradas.");
            } else {
                for (List<NamedEntity> entityList : collectedEntities) {
                    if (entityList != null) {
                        for (NamedEntity entity : entityList) {
                            entity.prettyPrint();
                        }
                    } else {
                        System.out.println("  - Se recibió una lista de entidades nula para un feed.");
                    }
                }
            }

            if (jsc != null) {
                jsc.close();
            }
            if (spark != null) {
            }
        } else {
            printHelp();
        }
    }
}
