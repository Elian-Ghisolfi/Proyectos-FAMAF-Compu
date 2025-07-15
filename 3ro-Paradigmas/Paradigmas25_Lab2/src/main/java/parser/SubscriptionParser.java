package parser;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import subscription.SingleSubscription;
import subscription.Subscription;

public class SubscriptionParser extends GeneralParser {

    public List<SingleSubscription> ParseJSON() {
        try (InputStream is = getClass().getResourceAsStream("/config/subscriptions.json")) {
            if (is == null) {
                throw new FileNotFoundException("Archivo no encontrado en recursos: config/subscriptions.json");
            }
            
            JSONArray array = new JSONArray(new JSONTokener(is));
            
            Subscription subscription = new Subscription(null);
            int length    = array.length();
            
            for (int i = 0; i < length; i++) {
                SingleSubscription singleSubscription = new SingleSubscription(null, null, null);
                
                JSONObject obj  = array.getJSONObject(i);
                
                String url      = obj.getString("url");
                singleSubscription.setUrl(url);

                JSONArray urlParams = obj.getJSONArray("urlParams");
                for (int j = 0; j < urlParams.length(); j++) {
                    singleSubscription.setUlrParams(urlParams.getString(j));
                }

                String urlType = obj.getString("urlType");
                singleSubscription.setUrlType(urlType);

                subscription.addSingleSubscription(singleSubscription);
            }

            List<SingleSubscription> mySubscriptions = subscription.getSubscriptionsList();

            return  mySubscriptions;
            
        } catch (FileNotFoundException e) {
            System.err.println("Error: Archivo de configuración no encontrado");
            e.printStackTrace();
            return null;
        } catch (IOException e) {
            System.err.println("Error de E/S al leer el archivo");
            e.printStackTrace();
            return null;
        } catch (Exception e) {
            System.err.println("Error inesperado al procesar el JSON");
            e.printStackTrace();
            return null;
        }
    }
}