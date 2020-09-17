package seth.cohen.visionlog;

import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.MenuItem;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationView;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.navigation.NavController;
import androidx.navigation.Navigation;
import androidx.navigation.ui.AppBarConfiguration;
import androidx.navigation.ui.NavigationUI;

import seth.cohen.visionlog.ui.journal.JournalFragment;
import seth.cohen.visionlog.ui.newdream.NewDreamFragment;
import seth.cohen.visionlog.ui.statistics.StatisticsFragment;

public class MainActivity extends AppCompatActivity implements BottomNavigationView.OnNavigationItemSelectedListener {
    public BottomNavigationView navView;
    private Toast backPressedToast;
    long back_pressed;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        navView = (BottomNavigationView) findViewById(R.id.nav_view);
        // Passing each menu ID as a set of Ids because each
        // menu should be considered as top level destinations.

        NavController navController = Navigation.findNavController(this, R.id.nav_host_fragment);
        NavigationUI.setupWithNavController(navView, navController);
        navView.setOnNavigationItemSelectedListener(this);
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

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        Fragment selectedFragment = null;

        EditText input = findViewById(R.id.dreamEditText);
        String strInput = input.getText().toString();
        if (strInput.matches("")){
            switch (item.getItemId()) {
                case R.id.navigation_newdream:
                    Log.d("test", "newdream");
                    selectedFragment = new NewDreamFragment();
                    break;
                case R.id.navigation_journal:
                    Log.d("test", "journal");
                    selectedFragment = new JournalFragment();
                    break;
                case R.id.navigation_statistics:
                    Log.d("test", "statistics");
                    selectedFragment = new StatisticsFragment();
                    break;
                default:
                    return false;
            }

            getSupportFragmentManager().beginTransaction().replace(R.id.nav_host_fragment, selectedFragment).commit();
        }
        else {
            navView.getMenu().getItem(0).setChecked(true);
            Toast.makeText(getBaseContext(), "Unsaved Input Detected", Toast.LENGTH_SHORT).show();
        }

        return true;
    }

}