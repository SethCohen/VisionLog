package seth.cohen.visionlog.db;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.Query;

import java.util.List;

@Dao
public interface DreamDAO {

    @Insert
    void insert(Dream dream);

    @Query("SELECT * FROM Dreams")
    List<Dream> getSavedDreamsList();
}
