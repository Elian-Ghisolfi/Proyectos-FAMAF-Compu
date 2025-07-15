package parser;

import java.io.FileNotFoundException;
import java.io.Serializable;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.io.Reader;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import subscription.SingleSubscription;
import subscription.Subscription;

public class SubscriptionParser extends GeneralParser implements Serializable {

    public List<SingleSubscription> ParseJSON() {
        List<SingleSubscription> mySubscriptions = new ArrayList<>();

        try (InputStream is = Objects.requireNonNull(
                getClass().getResourceAsStream("/config/subscriptions.json"),
                "Archivo de configuración no encontrado")) {
            Reader reader = new InputStreamReader(is);
            JSONArray array = new JSONArray(new JSONTokener(reader));

            Subscription subscription = new Subscription(null);

            for (int i = 0; i < array.length(); i++) {
                JSONObject obj = array.getJSONObject(i);

                if (!obj.has("url") || !obj.has("urlParams") || !obj.has("urlType")) {
                    throw new IllegalArgumentException(
                            "El objeto JSON en la posición " + i + " no tiene todos los campos requeridos");
                }

                JSONArray urlParams = obj.getJSONArray("urlParams");
                List<String> paramsList = new ArrayList<>();
                for (int j = 0; j < urlParams.length(); j++) {
                    paramsList.add(urlParams.getString(j));
                }

                SingleSubscription singleSubscription = new SingleSubscription(
                        obj.getString("url"),
                        paramsList,
                        obj.getString("urlType")
                );

                subscription.addSingleSubscription(singleSubscription);
            }

            mySubscriptions = subscription.getSubscriptionsList();

        } catch (FileNotFoundException e) {
            System.err.println("Error crítico: Archivo de configuración no encontrado");
            throw new RuntimeException("Archivo de configuración no encontrado", e);
        } catch (IOException e) {
            System.err.println("Error de E/S al leer el archivo de configuración");
            throw new RuntimeException("Error de E/S", e);
        } catch (Exception e) {
            System.err.println("Error inesperado al procesar el JSON: " + e.getMessage());
            throw new RuntimeException("Error procesando JSON", e);
        }

        return mySubscriptions;
    }
}
