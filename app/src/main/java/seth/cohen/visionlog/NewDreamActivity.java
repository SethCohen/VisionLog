package seth.cohen.visionlog;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.lifecycle.Observer;

import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.TimePickerDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import android.provider.CalendarContract;
import android.provider.MediaStore;
import android.text.format.DateFormat;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.TimePicker;
import android.widget.Toast;

import com.google.android.material.floatingactionbutton.FloatingActionButton;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import static android.app.Activity.*;

public class NewDreamActivity extends AppCompatActivity {

    TextView tvDate, tvTime;
    DatePickerDialog.OnDateSetListener setDateListener;
    TimePickerDialog.OnTimeSetListener setTimeListener;

    public int year, month, day, hour, minute;
    public String moodType = "average";
    public String title, dream, dreamType = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_new_dream);

        tvDate = findViewById(R.id.dateTV);
        tvTime = findViewById(R.id.timeTV);

        Calendar c = Calendar.getInstance();
        year = c.get(Calendar.YEAR);
        month = c.get(Calendar.MONTH);
        day = c.get(Calendar.DAY_OF_MONTH);
        hour = c.get(Calendar.HOUR_OF_DAY);
        minute = c.get(Calendar.MINUTE);

        SimpleDateFormat timedf = new SimpleDateFormat("h:mm aa");
        String formattedTime = timedf.format(c.getTime());
        tvTime.setText(formattedTime);

        SimpleDateFormat datedf = new SimpleDateFormat("MMM d, yyyy");
        String formattedDate = datedf.format(c.getTime());
        tvDate.setText(formattedDate);

        tvDate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                DatePickerDialog datePickerDialog = new DatePickerDialog(NewDreamActivity.this,setDateListener,year,month,day);
                datePickerDialog.show();
            }
        });

        setDateListener = new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker view, int year2, int month2, int day2) {
                Calendar calendar = Calendar.getInstance();
                calendar.set(year2, month2, day2);
                SimpleDateFormat sdf = new SimpleDateFormat("MMM d, yyyy");
                String dateString = sdf.format(calendar.getTime());
                tvDate.setText(dateString);

                year = year2;
                month = month2;
                day = day2;

            }
        };

        tvTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                TimePickerDialog timePickerDialog = new TimePickerDialog(NewDreamActivity.this,setTimeListener,hour,minute, DateFormat.is24HourFormat(NewDreamActivity.this));
                timePickerDialog.show();
            }
        });

        setTimeListener = new TimePickerDialog.OnTimeSetListener() {
            @Override
            public void onTimeSet(TimePicker view, int hour2, int minute2) {
                Calendar calendar = Calendar.getInstance();
                calendar.set(Calendar.HOUR_OF_DAY, hour2);
                calendar.set(Calendar.MINUTE, minute2);
                SimpleDateFormat sdf = new SimpleDateFormat("h:mm aa");
                String timeString = sdf.format(calendar.getTime());

                tvTime.setText(timeString);

                hour = hour2;
                minute = minute2;

            }
        };

        RadioGroup radioGroup = (RadioGroup) findViewById(R.id.radioGroup);
        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener()
        {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                RadioButton checkedRadioButton = (RadioButton) group.findViewById(checkedId);
                switch(checkedId){
                    case R.id.frownBtn:
                        moodType = "terrible";
                        break;
                    case R.id.slfrownBtn:
                        moodType = "bad";
                        break;
                    case R.id.neutralBtn:
                        moodType = "average";
                        break;
                    case R.id.slsmileBtn:
                        moodType = "good";
                        break;
                    case R.id.smileBtn:
                        moodType = "great";
                        break;
                }
            }
        });

        final Switch lucidSwitch = (Switch) findViewById(R.id.lucidSwitch);
        final Switch nightmareSwitch = (Switch) findViewById(R.id.nightmareSwitch);
        final Switch recurringSwitch = (Switch) findViewById(R.id.recurringSwitch);
        final Switch continuingSwitch = (Switch) findViewById(R.id.continuingSwitch);

        lucidSwitch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (lucidSwitch.isChecked()){
                    dreamType = "lucid";
                }
            }
        });
        nightmareSwitch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (nightmareSwitch.isChecked()){
                    RadioButton frownRadioBtn = (RadioButton) findViewById(R.id.frownBtn);
                    frownRadioBtn.setChecked(true);
                    dreamType = "nightmare";
                }
            }
        });
        recurringSwitch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (recurringSwitch.isChecked()){
                    dreamType = "recurring";
                }
            }
        });
        continuingSwitch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (continuingSwitch.isChecked()){
                    dreamType = "continuing";
                }
            }
        });


        FloatingActionButton saveFAB = (FloatingActionButton) findViewById(R.id.saveFAB);
        saveFAB.setOnClickListener(new View.OnClickListener() {
            @RequiresApi(api = Build.VERSION_CODES.KITKAT)
            @Override
            public void onClick(View v) {
                EditText titleET = (EditText) findViewById(R.id.titleEditText);
                EditText dreamET = (EditText) findViewById(R.id.dreamEditText);
                String strFileName = "";

                Calendar calendar = Calendar.getInstance();
                calendar.set(year, month, day, hour, minute);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-d-HH:mm");

                title = titleET.getText().toString();
                dream = dreamET.getText().toString();

                if (!title.equals("") && !dreamType.equals("")){ //title, dreamtype
                    strFileName = sdf.format(calendar.getTime()) + "-" + moodType + "-" + dreamType + "-" + title + ".txt";
                }
                if (title.equals("") && !dreamType.equals("")) { //no title, dreamtype
                    strFileName = sdf.format(calendar.getTime()) + "-" + moodType + "-" + dreamType + ".txt";
                }
                else if (!title.equals("") && dreamType.equals("")){ //title, no dreamtype
                    strFileName = sdf.format(calendar.getTime()) + "-" + moodType + "-" + title + ".txt";
                }
                else if (title.equals("") && dreamType.equals("")){ //no title, no dreamtype
                    strFileName = sdf.format(calendar.getTime()) + "-" + moodType + ".txt";
                }

                AlertDialog.Builder builder = new AlertDialog.Builder(NewDreamActivity.this);
                builder.setTitle("Are you sure?");
                final String finalStrFileName = strFileName;
                builder.setPositiveButton("Submit", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.dismiss();

                        FileOutputStream fos = null;
                        try {
                            fos = openFileOutput(finalStrFileName, MODE_PRIVATE);
                            fos.write(dream.getBytes());
                            Toast.makeText(NewDreamActivity.this, "Dream Saved", Toast.LENGTH_SHORT).show();
                        } catch (FileNotFoundException e) {
                            e.printStackTrace();
                        } catch (IOException e) {
                            e.printStackTrace();
                        } finally {
                            if (fos != null) {
                                try {
                                    fos.close();
                                } catch (IOException e) {
                                    e.printStackTrace();
                                }
                            }
                        }

                        finish();
                    }
                });
                builder.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int id) {
                        dialog.dismiss();
                    }
                });
                AlertDialog alert = builder.create();
                alert.show();

            }
        });


    }
}