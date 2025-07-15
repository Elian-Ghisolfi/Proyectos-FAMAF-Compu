package namedEntity.ne;

import namedEntity.NamedEntity;
import java.io.Serializable;

public class Person extends NamedEntity implements Serializable {

    private String personId;

    public Person(String name, String canonicalForm, int frequency, String personId) {
        super(name, canonicalForm, "Person", frequency);
        this.personId = personId;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }
}
