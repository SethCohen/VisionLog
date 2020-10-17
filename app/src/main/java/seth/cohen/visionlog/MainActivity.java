package seth.cohen.visionlog;

import android.os.Bundle;
import android.widget.Toast;

import com.google.android.material.bottomnavigation.BottomNavigationView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.NavigationUI;

public class MainActivity extends AppCompatActivity {
    public BottomNavigationView navView;
    private Toast backPressedToast;
    long back_pressed;
    Fragment newdreamFrag;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        navView = (BottomNavigationView) findViewById(R.id.nav_view);
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.

        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupWithNavController(navView, navController);
        //navView.setOnNavigationItemSelectedListener(this);

        //displayView(R.id.navigation_newdream);
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

    /*@Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        displayView(item.getItemId());

        return true;
    }

    public void displayView(int viewId){
        Fragment selectedFragment = null;

        newdreamFrag = new SettingsFragment();

        String strInput = "Test";

        Log.d("test", strInput);
        if (strInput.matches("")){
            switch (viewId) {
                case R.id.navigation_newdream:
                    Log.d("test", "newdream");
                    selectedFragment = new SettingsFragment();
                    break;
                case R.id.navigation_journal:
                    Log.d("test", "journal");
                    selectedFragment = new DreamsFragment();
                    break;
                case R.id.navigation_statistics:
                    Log.d("test", "statistics");
                    selectedFragment = new StatisticsFragment();
                    break;
            }

            getSupportFragmentManager().beginTransaction().replace(R.id.nav_host_fragment, selectedFragment).commit();
        }
        else {
            Toast.makeText(getBaseContext(), "Unsaved Input Detected", Toast.LENGTH_SHORT).show();
        }
    }*/
}