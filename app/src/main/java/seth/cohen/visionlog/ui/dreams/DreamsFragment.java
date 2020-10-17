package seth.cohen.visionlog.ui.dreams;

import android.app.ActionBar;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import seth.cohen.visionlog.NewDreamActivity;
import seth.cohen.visionlog.R;

public class DreamsFragment extends Fragment {

    private DreamsViewModel dreamsViewModel;


    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        dreamsViewModel =
                ViewModelProviders.of(this).get(DreamsViewModel.class);
        View root = inflater.inflate(R.layout.fragment_dreams, container, false);

        FloatingActionButton fab = (FloatingActionButton) root.findViewById(R.id.addFAB);

        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), NewDreamActivity.class));
            }
        });

        return root;
    }
}