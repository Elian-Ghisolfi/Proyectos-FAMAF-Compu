
import org.apache.spark.api.java.function.Function;
import java.io.InputStream;
import java.io.IOException;
import feed.Feed;
import httpRequest.httpRequester;
import parser.RssParser;
import java.io.Serializable;

public class UrlToFeedFunction implements Function<String, Feed>, Serializable {

    @Override
    public Feed call(String url) throws Exception {
        httpRequester requester = new httpRequester();
        try (InputStream inputStream = requester.getFeed(url)) {
            RssParser parser = new RssParser();
            Feed feed = parser.ParseXML(inputStream);
            if (feed == null) {
                System.err.println("El parser devolvió null para URL: " + url);
            }
            return feed;
        } catch (IOException e) {
            System.err.println("Error al hacer el http request a la url:" + url);
            return null;
        }
    }
}
