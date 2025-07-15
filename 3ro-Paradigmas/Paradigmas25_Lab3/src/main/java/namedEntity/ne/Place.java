package namedEntity.ne;

import namedEntity.NamedEntity;
import java.io.Serializable;

public class Place extends NamedEntity implements Serializable {

    public Place(String name, String canonicalForm, int frequency) {
        super(name, canonicalForm, "Place", frequency);
    }
}
