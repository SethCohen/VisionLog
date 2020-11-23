package seth.cohen.visionlog.db;

import androidx.room.ColumnInfo;
import androidx.room.Entity;
import androidx.room.PrimaryKey;

@Entity(tableName = "Dreams")
public class Dream {

    @PrimaryKey(autoGenerate = true)
    private int id;

    @ColumnInfo(name = "Year")
    private int year;

    @ColumnInfo(name = "Month")
    private int month;

    @ColumnInfo(name = "Day")
    private int day;

    @ColumnInfo(name = "Hour")
    private int hour;

    @ColumnInfo(name = "Minute")
    private int minute;

    @ColumnInfo(name = "Feel")
    private String feel;

    @ColumnInfo(name = "Type")
    private String type;

    @ColumnInfo(name = "Title")
    private String title;

    @ColumnInfo(name = "Message")
    private String message;

    public Dream(int year, int month, int day, int hour, int minute, String feel, String type, String title, String message) {
        this.year = year;
        this.month = month;
        this.day = day;
        this.hour = hour;
        this.minute = minute;
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

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public int getMinute() {
        return minute;
    }

    public void setMinute(int minute) {
        this.minute = minute;
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
                "year=" + year +
                ", month=" + month +
                ", day=" + day +
                ", hour=" + hour +
                ", minute=" + minute +
                ", feel='" + feel + '\'' +
                ", type='" + type + '\'' +
                ", title='" + title + '\'' +
                ", message='" + message + '\'' +
                '}';
    }
}
