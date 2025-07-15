package parser;

import java.io.InputStream;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import feed.Feed;
import httpRequest.httpRequester;

/*
 * Esta clase implementa el parser de feed de tipo reddit (json)
 * pero no es necesario su implemntacion 
 * */

public class RedditParser extends GeneralParser {

    public Feed ParseReddit(String url, String param){
        try{
            httpRequester request  = new httpRequester(); 
            InputStream redditFeed = request.getFeed(url, param);  // Tu InputStream de la HTTP request
            
            JSONObject jsonResponse = new JSONObject(new JSONTokener(redditFeed));
            JSONArray children = jsonResponse.getJSONObject("data").getJSONArray("children");

            Feed feed = new Feed(param);

            for (int i = 0; i < children.length(); i++) {
                JSONObject post = children.getJSONObject(i).getJSONObject("data");
                String     title = post.getString("title");
                String     description = post.getString("selftext");
                long     pubDateStr = post.getLong("created_utc");
                String     link = post.getString("url");

                // Parseamos la fecha
                Date pubDate = ParseDateLong(pubDateStr);

                // Añadimos el articulo al feed
                addArticle(feed, title, description, pubDate, link);
            }
            return feed;
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }
}