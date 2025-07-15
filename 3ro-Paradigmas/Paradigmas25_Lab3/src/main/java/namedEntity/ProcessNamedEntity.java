package namedEntity;

import java.io.Serializable;
import java.util.List;

import feed.Feed;
import namedEntity.heuristic.Heuristic;

/**
 * Clase responsable del procesamiento de entidades nombradas Separa la lógica
 * de análisis de entidades del main
 */
public class ProcessNamedEntity implements Serializable{

    private final Heuristic heuristic;

    public ProcessNamedEntity(Heuristic heuristic) {
        this.heuristic = heuristic;
    }

    /**
     * Procesa y muestra entidades nombradas de todos los feeds
     */
    public void processAndDisplayEntities(List<Feed> feeds) {
        for (int i = 0; i < feeds.size(); i++) {
            Feed feed = feeds.get(i);
            processFeedEntity(feed);
        }
    }
    /**
     * Procesa entidades nombradas de un feed específico
     */
    public void processFeedEntity(Feed feed) {
        this.heuristic.computeEntities(feed);
    }
    
    public List<NamedEntity> getDetectedEntities(){
        return this.heuristic.getEntitiesList();
    }

    public void processPrintEntities(){
        this.heuristic.printEntities();
    }
}
