package parser;

import java.io.InputStream;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import feed.Feed;
import httpRequest.httpRequester;

public class RssParser extends GeneralParser {
   public Feed ParseXML(String url,String param) {	
      try {      	  
	    	     
         //Input the XML file
        httpRequester request = new httpRequester();
            
        InputStream rssFeed = request.getFeed(url,param);      

	     //Creating DocumentBuilder
	     DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	     DocumentBuilder docBuilder = dbFactory.newDocumentBuilder();
	     Document xmldoc = docBuilder.parse(rssFeed);
	      
	     NodeList nList = xmldoc.getElementsByTagName("item");
        int length     = nList.getLength();

        Feed feed = new Feed(param);


	     //Iterating through all the child elements of the root
	     for (int i = 0; i < length; i++) {      
            Node nNode = nList.item(i);
            
            if (nNode.getNodeType() == Node.ELEMENT_NODE) {     
            Element eElement = (Element) nNode;
            String title = eElement.getElementsByTagName("title").item(0).getTextContent();
            String description = eElement.getElementsByTagName("description").item(0).getTextContent();
            String pubDateStr = eElement.getElementsByTagName("pubDate").item(0).getTextContent();
            String link = eElement.getElementsByTagName("link").item(0).getTextContent();

            // Parseamos la fecha
            Date pubDate = ParseDateStr(pubDateStr);

            // Añadimos el articulo al feed
            addArticle(feed, title, description, pubDate, link);
         }   
      } 
         return feed;
      } 
      catch (Exception e) {
         e.printStackTrace();
         return null;
      }
   }
}
