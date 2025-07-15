
package namedEntity.ne;
import namedEntity.NamedEntity;



public class Organization extends NamedEntity {
    private int memberCount;
    private String organizationType;

    public Organization(String name, String canonicalForm, int frequency, 
                       int memberCount, String organizationType) {
        super(name, canonicalForm, "Organization", frequency);
        this.memberCount = memberCount;
        this.organizationType = organizationType;
    }

    public int getMemberCount() { return memberCount; }
    public void setMemberCount(int memberCount) { this.memberCount = memberCount; }
    
    public String getOrganizationType() { return organizationType; }
    public void setOrganizationType(String organizationType) { 
        this.organizationType = organizationType; 
    }
}