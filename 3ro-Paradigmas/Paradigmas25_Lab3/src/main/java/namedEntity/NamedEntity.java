package namedEntity;
import java.io.Serializable;

/*Esta clase modela la nocion de entidad nombrada*/
public class NamedEntity implements Serializable{

    String name;
    String canonicalForm;
    String category;
    int frequency;

    public NamedEntity(String name, String canonicalForm, String category, int frequency) {
        super();
        this.name = name;
        this.canonicalForm = canonicalForm;
        this.category = category;
        this.frequency = frequency;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public String getCanonicalForm() {
        return canonicalForm;
    }

    public void setCanonicalForm(String canonicalForm) {
        this.canonicalForm = canonicalForm;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public int getFrequency() {
        return frequency;
    }

    public void setFrequency(int frequency) {
        this.frequency = frequency;
    }

    public void incFrequency() {
        this.frequency++;
    }

    @Override
    public String toString() {
        return "NamedEntity [name=" + name + ", canonicalForm=" + canonicalForm
                + ", category=" + category + ", frequency=" + frequency + "]";
    }

    public void prettyPrint() {
        System.out.println("Name: " + this.getName()
                + ", Category: " + this.getCategory()
                + ", Frequency: " + this.getFrequency());
    }

}
