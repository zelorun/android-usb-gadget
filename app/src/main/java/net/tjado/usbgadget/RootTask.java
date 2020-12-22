package net.tjado.usbgadget;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Pair;

public class RootTask extends AsyncTask<Void, Void, Pair> {
    OnRootTaskListener listener;
    Context mContext;
    String[] mCommands;

    public interface OnRootTaskListener {
        public void OnRootTaskFinish(Pair response);
    }

    public RootTask(String command, OnRootTaskListener listener) {
        mCommands = new String[] {command};
        this.listener = listener;
    }

    public RootTask(String[] commands, OnRootTaskListener listener) {
        mCommands = commands;
        this.listener = listener;
    }

    @Override
    protected Pair doInBackground(Void... params) {
        Pair cr = ExecuteAsRootUtil.execute(mCommands);
        return cr;
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected void onPostExecute(Pair result) {
        if( listener != null ) {
            listener.OnRootTaskFinish(result);
        }
    }
}
