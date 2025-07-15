package parser;

import java.io.InputStream;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import feed.Article;
import feed.Feed;

public class RssParser extends GeneralParser implements Serializable {

    public Feed ParseXML(InputStream rssFeed) {
        try {

            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder docBuilder = dbFactory.newDocumentBuilder();

            Feed resultFeed = null;

            try {
                Document xmldoc = docBuilder.parse(rssFeed);

                // Obtenemos el formato del documento xml
                String formatName = xmldoc.getDocumentElement().getNodeName();

                if (formatName.equals("rss")) {
                    resultFeed = rssFormat(xmldoc);
                } else if (formatName.equals("feed")) {
                    resultFeed = parseFeedFormat(xmldoc);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            return resultFeed;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private Feed rssFormat(Document xml) {

        Feed feed = new Feed(null);
        NodeList nList = xml.getElementsByTagName("item");
        int length = nList.getLength();

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

    private Feed parseFeedFormat(Document xmldoc) {

        Feed resultFeed = new Feed(null);

        NodeList nList = xmldoc.getElementsByTagName("entry");

        for (int i = 0; i < nList.getLength(); i++) {
            Node nNode = nList.item(i);

            if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                Element eElement = (Element) nNode;
                String Title = eElement.getElementsByTagName("title").item(0).getTextContent();;
                String Description = eElement.getElementsByTagName("content").item(0).getTextContent();
                String Link = "";
                try {

                    Element linkElement = (Element) eElement.getElementsByTagName("link").item(0);
                    if (linkElement != null) {
                        String href = linkElement.getAttribute("href");
                        if (href != null && !href.isEmpty()) {
                            Link = href;
                        } else {
                            Link = linkElement.getTextContent();
                        }
                    }
                } catch (NullPointerException e) {
                    Link = "No existe link";
                }
                String PubDate = eElement.getElementsByTagName("published").item(0).getTextContent();
                Date pubDate = null;
                if (PubDate != null) {
                    try {
                        //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss",
                                Locale.ENGLISH);

                        // 2025-05-11T11:00:31+00:00
                        pubDate = dateFormat.parse(PubDate);
                    } catch (Exception e) {
                        e.printStackTrace();
                        System.out.println("Error al intentar obtener la fecha del articulo\n");
                    }
                }
                if (Title != null && Description != null && Link != null) {
                    Article Article = new Article(Title, Description, pubDate, Link);
                    resultFeed.addArticle(Article);
                } else {
                    System.out.println("Error al intentar obtener datos del articulo\n");
                }
            }
        }
        return resultFeed;
    }
}
