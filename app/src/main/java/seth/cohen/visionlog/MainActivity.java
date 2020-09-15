package seth.cohen.visionlog;

import android.os.Bundle;
import android.os.Handler;
import android.widget.Toast;

import com.google.android.material.bottomnavigation.BottomNavigationView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

public class MainActivity extends AppCompatActivity {
    //test to see if git works
    private Toast backPressedToast;
    long back_pressed;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        BottomNavigationView navView = findViewById(R.id.nav_view);
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.
        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupWithNavController(navView, navController);
    }

    @Override
    public void onBackPressed() {
        if (back_pressed + 2000 > System.currentTimeMillis()){
            backPressedToast.cancel();
            super.onBackPressed();
            this.finishAffinity();
            return;
        }
        else{
            backPressedToast = Toast.makeText(getBaseContext(), "Press again to quit.", Toast.LENGTH_SHORT);
            backPressedToast.show();
        }
        back_pressed = System.currentTimeMillis();
    }

}