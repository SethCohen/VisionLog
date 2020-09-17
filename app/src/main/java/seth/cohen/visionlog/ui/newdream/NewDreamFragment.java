package seth.cohen.visionlog.ui.newdream;

import android.app.ActionBar;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import seth.cohen.visionlog.MainActivity;
import seth.cohen.visionlog.R;

public class NewDreamFragment extends Fragment {

    private ActionBar toolbar;
    private NewDreamViewModel newDreamViewModel;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        newDreamViewModel =
                ViewModelProviders.of(this).get(NewDreamViewModel.class);
        final View root = inflater.inflate(R.layout.fragment_newdream, container, false);
        final TextView spinnertv = root.findViewById(R.id.text_spinner);

        Spinner spinner = root.findViewById(R.id.dreamTypeSpinner);
        ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(getActivity(), R.array.dream_type_array, android.R.layout.simple_spinner_item);
        adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner.setAdapter(adapter);

        final View dreamtypeview = root.findViewById(R.id.typeview);

        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            public void onItemSelected(AdapterView<?> parent, View view,
                                       int position, long id) {
                //String text = parent.getItemAtPosition(position).toString();
                //Toast.makeText(parent.getContext(), text, Toast.LENGTH_SHORT).show();

                if (position == 0){
                    dreamtypeview.setBackgroundColor(getResources().getColor(R.color.colorRegularDream));
                }
                else if (position == 1){
                    dreamtypeview.setBackgroundColor(getResources().getColor(R.color.colorLucidDream));
                }
                else if (position == 2){
                    dreamtypeview.setBackgroundColor(getResources().getColor(R.color.colorEuphoricDream));
                }
                else if (position == 3){
                    dreamtypeview.setBackgroundColor(getResources().getColor(R.color.colorThrillerDream));
                }
                else if (position == 4){
                    dreamtypeview.setBackgroundColor(getResources().getColor(R.color.colorNightmareDream));
                }
                else if (position == 5){
                    dreamtypeview.setBackgroundColor(getResources().getColor(R.color.colorLucidNightmareDream));
                }
            }
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
            }
        });

        final EditText input = root.findViewById(R.id.dreamEditText);
        FloatingActionButton fab = root.findViewById(R.id.saveFAB);

        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                final String strInput = input.getText().toString();
                if (!strInput.matches("")){
                    Toast.makeText(getContext(),"Edit Text Is Not Empty",Toast.LENGTH_SHORT).show();
                }
            }
        });


        newDreamViewModel.getSpinnerText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {

                spinnertv.setText(s);
            }
        });

        return root;
    }
}