
package namedEntity.ne;
import namedEntity.NamedEntity;

public class Person extends NamedEntity {
    private String personId;

    public Person(String name, String canonicalForm, int frequency, String personId) {
        super(name, canonicalForm, "Person", frequency);
        this.personId = personId;
    }

    public String getPersonId() { return personId; }
    public void setPersonId(String personId) { this.personId = personId; }
}