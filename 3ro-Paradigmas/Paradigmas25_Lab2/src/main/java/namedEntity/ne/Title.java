package namedEntity.ne;

public class Title extends Person {
    private boolean isProfessional;

    public Title(String name, String canonicalForm, int frequency, String personId, 
                boolean isProfessional) {
        super(name, canonicalForm, frequency, personId);
        this.isProfessional = isProfessional;
    }

    public boolean isProfessional() { return isProfessional; }
    public void setProfessional(boolean professional) { isProfessional = professional; }
}