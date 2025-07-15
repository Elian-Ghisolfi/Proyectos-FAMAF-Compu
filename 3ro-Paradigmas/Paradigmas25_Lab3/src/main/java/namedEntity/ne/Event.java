package namedEntity.ne;

import java.io.Serializable;
import namedEntity.NamedEntity;

public class Event extends NamedEntity implements Serializable {

    private String date;
    private boolean isRecurring;

    public Event(String name, String canonicalForm, int frequency,
            String date, boolean isRecurring) {
        super(name, canonicalForm, "Event", frequency);
        this.date = date;
        this.isRecurring = isRecurring;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public boolean isRecurring() {
        return isRecurring;
    }

    public void setRecurring(boolean recurring) {
        isRecurring = recurring;
    }
}
