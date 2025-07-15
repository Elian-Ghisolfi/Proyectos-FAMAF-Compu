package parser;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import feed.Article;
import feed.Feed;

/*Esta clase modela los atributos y metodos comunes a todos los distintos tipos de parser existentes en la aplicacion*/
public abstract class GeneralParser {
    
    public Date ParseDateStr(String pubDateStr){
        Date pubDate = null;
        try {
                SimpleDateFormat format = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.US);
                pubDate = format.parse(pubDateStr);
                return pubDate;
            } 
            catch (ParseException e) {
                System.err.println("Error parsing date: " + pubDateStr);
                return null;
        }
    }

    public Date ParseDateLong(long pubDateLong){
        Date date = new Date(pubDateLong * 1000L);
        return  date;
    }

    public void addArticle(Feed feed, String title, String description, Date pubDate, String link){
        if (title != null && link != null) {
                  Article art = new Article(title, description, pubDate, link);
                  feed.addArticle(art);
               }
        else {
            System.err.println("ERROR: Problema con el articulo.");
        }
    }
}
