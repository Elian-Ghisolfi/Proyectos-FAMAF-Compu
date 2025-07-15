package namedEntity.ne;

import java.io.Serializable;

public class OtherPlace extends Place implements Serializable {

    public OtherPlace(String name, String canonicalForm, int frequency) {
        super(name, canonicalForm, frequency);
    }
}
