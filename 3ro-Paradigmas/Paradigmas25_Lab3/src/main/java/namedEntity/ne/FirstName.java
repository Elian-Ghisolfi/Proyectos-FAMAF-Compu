package namedEntity.ne;

import java.util.List;
import java.io.Serializable;

public class FirstName extends Person implements Serializable {

    private String origin;
    private List<String> alternativeForms;

    public FirstName(String name, String canonicalForm, int frequency, String personId,
            String origin, List<String> alternativeForms) {
        super(name, canonicalForm, frequency, personId);
        this.origin = origin;
        this.alternativeForms = alternativeForms;
    }

    public String getOrigin() {
        return origin;
    }

    public void setOrigin(String origin) {
        this.origin = origin;
    }

    public List<String> getAlternativeForms() {
        return alternativeForms;
    }

    public void setAlternativeForms(List<String> alternativeForms) {
        this.alternativeForms = alternativeForms;
    }
}
