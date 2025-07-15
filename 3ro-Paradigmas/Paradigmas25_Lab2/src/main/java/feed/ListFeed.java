package feed;

import java.util.ArrayList;
import java.util.List;

/* Esta clase genera una lista de Feed para usar de forma general */
public class ListFeed {
    private List<Feed> feedsList;

    public ListFeed(){
        super();
        this.feedsList = new ArrayList<Feed>();
    }

    public void setFeedsList(List<Feed> feedL){
        this.feedsList = feedL;
    }

    public List<Feed> getFeedsList(){
        return feedsList;
    }

    public void addFeed(Feed f){
        this.getFeedsList().add(f);
    }

    public Feed getFeed(int i){
       return this.getFeedsList().get(i);
    }

    public int getNumberOfFeeds(){
        return this.getFeedsList().size();
    }
}
