package namedEntity.ne;

import java.io.Serializable;

public class Address extends Place implements Serializable {

    private String city;

    public Address(String name, String canonicalForm, int frequency, String city) {
        super(name, canonicalForm, frequency);
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }
}
