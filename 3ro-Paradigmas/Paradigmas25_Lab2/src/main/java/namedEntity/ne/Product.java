
package namedEntity.ne;
import namedEntity.NamedEntity;

public class Product extends NamedEntity {
    private boolean isCommercial;
    private String producer;

    public Product(String name, String canonicalForm, int frequency, 
                  boolean isCommercial, String producer) {
        super(name, canonicalForm, "Product", frequency);
        this.isCommercial = isCommercial;
        this.producer = producer;
    }

    public boolean isCommercial() { return isCommercial; }
    public void setCommercial(boolean commercial) { isCommercial = commercial; }
    
    public String getProducer() { return producer; }
    public void setProducer(String producer) { this.producer = producer; }
}