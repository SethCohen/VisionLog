package seth.cohen.visionlog.displaylist;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import seth.cohen.visionlog.R;

public class Holder extends RecyclerView.ViewHolder implements View.OnClickListener{

    ImageView mImageView;
    TextView mDate, mTitle, mMessage, mTypes;
    View mFeel;

    ItemClickListener itemClickListener;

    Holder(@NonNull View itemView) {
        super(itemView);

        this.mImageView = itemView.findViewById(R.id.feelIV);
        this.mDate = itemView.findViewById(R.id.dateTV);
        this.mTitle = itemView.findViewById(R.id.titleTV);
        this.mMessage = itemView.findViewById(R.id.messageTV);
        this.mTypes = itemView.findViewById(R.id.typeTV);
        this.mFeel = itemView.findViewById(R.id.feelView);

        itemView.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        this.itemClickListener.onItemClickListener(v, getLayoutPosition());
    }

    public void setItemClickListener(ItemClickListener ic){
        this.itemClickListener = ic;
    }
}
