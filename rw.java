class rw
{
	public static void main(String[] args) {
		data d = new data(0);
		reader r1 = new reader(d);
		reader r2 = new reader(d);
		writer w1 = new writer(d, 1);
		r1.start();
		r2.start();
		w1.start();
	}
}

class reader extends Thread {
	data d;
	public reader(data i) { d = i;}
	public void run() {
		int t;
		while (true) {
			t = d.read();
		}
	}
}

class writer extends Thread {
	data d;
	int value;
	public writer(data i, int j) { d = i; value = j;}
	public void run() {
		while (true) {
			d.write(value);
		}
	}
}

class data {
	int item;
	int rnum;
	int wnum;
	public synchronized void rinc() {
		while (wnum > 0) {
			try {wait();}
			catch (InterruptedException e) {};
		} 
		rnum = rnum + 1;
	}
	public synchronized void rdec() {
		rnum = rnum - 1;
		if ((rnum == 0) && (wnum == 0))
			notifyAll();
	}
	public synchronized void winc() {
    while ((wnum + rnum) > 0) {
			try {wait();}
    	catch (InterruptedException e) {};
		}
		wnum = wnum + 1; 
	}
	public synchronized void wdec() {
		wnum = wnum - 1;
		if ((wnum == 0) && (rnum == 0)) notifyAll();
	}
	public data(int j) { item = j; rnum = 0; wnum = 0;}
	public int read() { int t; rinc(); t = item; rdec(); return t;}
	public void write(int i) {
		winc();
		item = i;
		wdec();
	}
}
