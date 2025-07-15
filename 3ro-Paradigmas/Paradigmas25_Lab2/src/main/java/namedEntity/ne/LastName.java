package namedEntity.ne;

public class LastName extends Person {
    private String origin;

    public LastName(String name, String canonicalForm, int frequency, String personId, String origin) {
        super(name, canonicalForm, frequency, personId);
        this.origin = origin;
    }

    public String getOrigin() { return origin; }
    public void setOrigin(String origin) { this.origin = origin; }
}
