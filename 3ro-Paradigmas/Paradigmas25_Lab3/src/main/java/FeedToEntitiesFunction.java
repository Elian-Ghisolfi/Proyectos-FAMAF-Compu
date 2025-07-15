
import org.apache.spark.api.java.function.Function;
import feed.Feed;
import namedEntity.NamedEntity;
import namedEntity.ProcessNamedEntity;
import namedEntity.heuristic.Heuristic;
import namedEntity.heuristic.QuickHeuristic;
import java.util.List;
import java.io.Serializable;

public class FeedToEntitiesFunction implements Function<Feed, List<NamedEntity>>, Serializable {

    @Override
    public List<NamedEntity> call(Feed feed) throws Exception {
        if (feed == null) {
            return null;
        }
        Heuristic heuristic = new QuickHeuristic();
        ProcessNamedEntity processor = new ProcessNamedEntity(heuristic);
        processor.processFeedEntity(feed);
        return processor.getDetectedEntities();
    }
}
