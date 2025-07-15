package namedEntity.ne;

public class Country extends Place {
    private long population;
    private String officialLanguage;

    public Country(String name, String canonicalForm, int frequency, 
                  long population, String officialLanguage) {
        super(name, canonicalForm, frequency);
        this.population = population;
        this.officialLanguage = officialLanguage;
    }

    public long getPopulation() { return population; }
    public void setPopulation(long population) { this.population = population; }
    
    public String getOfficialLanguage() { return officialLanguage; }
    public void setOfficialLanguage(String officialLanguage) { 
        this.officialLanguage = officialLanguage; 
    }
}