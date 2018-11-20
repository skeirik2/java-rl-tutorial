class Sum {
	static public int sum = 0; // static
	public static void main(String[] args) {
		sum = 0;
		for (int i=0; i<=100; i++) sum += i;
		System.out.println(sum);
	}
}
