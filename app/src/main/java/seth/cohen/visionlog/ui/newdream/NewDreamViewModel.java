package seth.cohen.visionlog.ui.newdream;

import androidx.lifecycle.LiveData;
import androidx.lifecycle.MutableLiveData;
import androidx.lifecycle.ViewModel;

public class NewDreamViewModel extends ViewModel {

    private MutableLiveData<String> mSpinnerText;

    public NewDreamViewModel() {
        mSpinnerText = new MutableLiveData<>();
        mSpinnerText.setValue("Type:");
    }

    public LiveData<String> getSpinnerText() {
        return mSpinnerText;
    }
}