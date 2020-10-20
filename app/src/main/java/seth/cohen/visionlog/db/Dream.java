package seth.cohen.visionlog.db;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "Dreams")
public class Dream {

    @PrimaryKey(autoGenerate = true)
    private int id;

    @ColumnInfo(name = "Date")
    private String date;

    @ColumnInfo(name = "Time")
    private String time;

    @ColumnInfo(name = "Feel")
    private String feel;

    @ColumnInfo(name = "Type")
    private String type;

    @ColumnInfo(name = "Title")
    private String title;

    @ColumnInfo(name = "Message")
    private String message;

    public Dream(String date, String time, String feel, String type, String title, String message) {
        this.date = date;
        this.time = time;
        this.feel = feel;
        this.type = type;
        this.title = title;
        this.message = message;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getFeel() {
        return feel;
    }

    public void setFeel(String feel) {
        this.feel = feel;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    @Override
    public String toString() {
        return "Dream{" +
                "date='" + date + '\'' +
                ", time=" + time + '\'' +
                ", feel=" + feel + '\'' +
                ", type=" + type + '\'' +
                ", title=" + title + '\'' +
                ", message=" + message + '\'' +
                '}';
    }
}
