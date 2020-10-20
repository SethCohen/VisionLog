package seth.cohen.visionlog.displaylist;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

import seth.cohen.visionlog.R;

public class Adapter extends RecyclerView.Adapter<Holder>{

    Context c;
    ArrayList<Model> models;

    public Adapter(Context c, ArrayList<Model> models) {
        this.c = c;
        this.models = models;
    }

    @NonNull
    @Override
    public Holder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.row, null);

        return new Holder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull Holder holder, int position) {

        holder.mDate.setText(models.get(position).getDate());
        holder.mTitle.setText(models.get(position).getTitle());
        holder.mMessage.setText(models.get(position).getMessage());
        holder.mTypes.setText(models.get(position).getTypes());
        holder.mImageView.setImageResource(models.get(position).getImg());
        holder.mFeel.setBackgroundResource(models.get(position).getFeel());

    }

    @Override
    public int getItemCount() {
        return models.size();
    }
}
