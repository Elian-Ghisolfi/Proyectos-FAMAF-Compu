package namedEntity.ne;


public class Address extends Place {
    private String city;

    public Address(String name, String canonicalForm, int frequency, String city) {
        super(name, canonicalForm, frequency);
        this.city = city;
    }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }
}