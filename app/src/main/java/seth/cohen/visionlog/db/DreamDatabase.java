package seth.cohen.visionlog.db;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import seth.cohen.visionlog.db.Dream;
import seth.cohen.visionlog.db.DreamDAO;

@Database(entities = {Dream.class}, version = 1)
public abstract class DreamDatabase extends RoomDatabase {

    private static String DATABASE = "DemoAppDatabase";
    private static DreamDatabase instance;

    static DreamDatabase getInstance(Context context) {
        if (instance == null) {
            instance = Room.databaseBuilder(
                    context.getApplicationContext(),
                    DreamDatabase.class,
                    DATABASE)
                    .allowMainThreadQueries()
                    .build();
        }
        return instance;
    }

    public abstract DreamDAO getDreamDAO();
}
