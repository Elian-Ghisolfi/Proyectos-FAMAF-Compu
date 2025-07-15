package namedEntity.ne;

import namedEntity.NamedEntity;
import java.io.Serializable;

public class Date extends NamedEntity implements Serializable {

    private boolean isPrecise;

    public Date(String name, String canonicalForm, int frequency, boolean isPrecise) {
        super(name, canonicalForm, "Date", frequency);
        this.isPrecise = isPrecise;
    }

    public boolean isPrecise() {
        return isPrecise;
    }

    public void setPrecise(boolean precise) {
        isPrecise = precise;
    }
}
