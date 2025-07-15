
package namedEntity.ne;
import namedEntity.NamedEntity;



public class Place extends NamedEntity {
    public Place(String name, String canonicalForm, int frequency) {
        super(name, canonicalForm, "Place", frequency);
    }
}