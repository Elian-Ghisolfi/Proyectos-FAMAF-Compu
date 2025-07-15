package namedEntity.ne;

import java.io.Serializable;

public class City extends Place implements Serializable {

    private String country;
    private boolean isCapital;
    private long population;

    public City(String name, String canonicalForm, int frequency,
            String country, boolean isCapital, long population) {
        super(name, canonicalForm, frequency);
        this.country = country;
        this.isCapital = isCapital;
        this.population = population;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public boolean isCapital() {
        return isCapital;
    }

    public void setCapital(boolean capital) {
        isCapital = capital;
    }

    public long getPopulation() {
        return population;
    }

    public void setPopulation(long population) {
        this.population = population;
    }
}
