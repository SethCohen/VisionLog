package seth.cohen.visionlog;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class Entree extends AppCompatActivity {

    ImageView mImageIV;
    TextView mDateTV, mTitleTV, mMessageTV, mTypesTV;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_entree);

        mTitleTV = findViewById(R.id.titleTV);
        mMessageTV = findViewById(R.id.messageTV);
        mTypesTV = findViewById(R.id.typeTV);
        mDateTV = findViewById(R.id.dateTV);
        mImageIV = findViewById(R.id.feelIcon);
    }
}