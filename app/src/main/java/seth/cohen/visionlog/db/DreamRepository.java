package seth.cohen.visionlog.db;

import android.content.Context;
import android.os.AsyncTask;

import java.util.List;
import java.util.logging.Handler;

public class DreamRepository {

    private DreamDatabase dreamDatabase;

    public DreamRepository(Context context){
        dreamDatabase = DreamDatabase.getInstance(context);
    }

    public void insert(final Dream dream){
//        AsyncTask.execute(new Runnable() {
//            @Override
//            public void run() {
//                userDatabase.getUserDao().insertUserData(user);
//            }
//        });

        dreamDatabase.getDreamDAO().insert(dream);
    }

    public void deleteUser(Dream user){

    }

    public List<Dream> getTableData(){
        return dreamDatabase.getDreamDAO().getSavedDreamsList();
    }

}
