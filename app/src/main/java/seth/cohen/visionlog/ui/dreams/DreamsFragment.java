package seth.cohen.visionlog.ui.dreams;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.lifecycle.ViewModelProviders;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.util.ArrayList;
import java.util.List;

import seth.cohen.visionlog.NewDreamActivity;
import seth.cohen.visionlog.R;
import seth.cohen.visionlog.db.Dream;
import seth.cohen.visionlog.db.DreamRepository;
import seth.cohen.visionlog.displaylist.Adapter;
import seth.cohen.visionlog.displaylist.Model;

public class DreamsFragment extends Fragment {

    private DreamsViewModel dreamsViewModel;
    private static DreamRepository dreamRepository;

    RecyclerView mRecyclerView;
    Adapter adapter;

    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState) {
        dreamsViewModel =
                ViewModelProviders.of(this).get(DreamsViewModel.class);
        View root = inflater.inflate(R.layout.fragment_dreams, container, false);

        dreamRepository = new DreamRepository(getActivity());

        FloatingActionButton fab = (FloatingActionButton) root.findViewById(R.id.addFAB);

        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                startActivity(new Intent(getActivity(), NewDreamActivity.class));
            }
        });

        /*Button button = root.findViewById(R.id.button);

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                List<Dream> dreamList = dreamRepository.getTableData();
                for(Dream dream : dreamList){
                    System.out.println(dream);
                }
            }
        });*/


        mRecyclerView = root.findViewById(R.id.recyclerView);
        mRecyclerView.setLayoutManager(new GridLayoutManager(getActivity(),1));

        adapter = new Adapter(getActivity(), getMyList());
        mRecyclerView.setAdapter(adapter);

        return root;
    }

    private ArrayList<Model> getMyList() {
        ArrayList<Model> models = new ArrayList<>();
        List<Dream> dreamList = dreamRepository.getTableData();

        for(Dream dream : dreamList){
            System.out.println(dream);

            Model m = new Model();
            m.setDate(dream.getDate() + " " + dream.getTime());
            m.setTitle(dream.getTitle());
            m.setMessage(dream.getMessage());
            m.setTypes(dream.getType());
            m.setFeel(R.color.view);

            switch (dream.getFeel()){
                case "terrible":
                    m.setImg(R.drawable.card_5_terrible);
                    //m.setFeel(R.color.terrible);
                    break;
                case "bad":
                    m.setImg(R.drawable.card_4_bad);
                    //m.setFeel(R.color.bad);
                    break;
                case "average":
                    m.setImg(R.drawable.card_3_average);
                    //m.setFeel(R.color.neutral);
                    break;
                case "good":
                    m.setImg(R.drawable.card_2_good);
                    //m.setFeel(R.color.good);
                    break;
                case "amazing":
                    m.setImg(R.drawable.card_1_amazing);
                    //m.setFeel(R.color.amazing);
                    break;
            }
            models.add(m);
        }


        return models;

    }

}