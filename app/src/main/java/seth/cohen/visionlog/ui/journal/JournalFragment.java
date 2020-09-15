package seth.cohen.visionlog.ui.journal;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.Observer;
import androidx.lifecycle.ViewModelProviders;

import seth.cohen.visionlog.R;

public class JournalFragment extends Fragment {

    private JournalViewModel journalViewModel;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        journalViewModel =
                ViewModelProviders.of(this).get(JournalViewModel.class);
        View root = inflater.inflate(R.layout.fragment_journal, container, false);
        final TextView textView = root.findViewById(R.id.text_dashboard);
        journalViewModel.getText().observe(getViewLifecycleOwner(), new Observer<String>() {
            @Override
            public void onChanged(@Nullable String s) {
                textView.setText(s);
            }
        });
        return root;
    }
}