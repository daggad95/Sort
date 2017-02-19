int[] numbers;
ArrayList<Integer> selection;
ArrayList<Integer> insertion;
int COLS = 10;
int OFFSET = 100;
int SIZE = 100;
int state;

void setup() {
  numbers = new int[SIZE];
  selection = new ArrayList<Integer>(); 
  insertion = new ArrayList<Integer>();
  
  for (int i = 0; i < SIZE; i++) {
    numbers[i] = (int) random(SIZE - 10) + 10;
  }
  
  //selectionSort();
  insertionSort();
  print(insertion.size());
  size(800, 800);
  state = 0;
}

void draw() {
  background(0);
  
  //drawing array
  int maxSize = (width - 2 * OFFSET) / COLS;
  int start = state * SIZE;
  int end = start + SIZE;
  for (int i = start; i < end; i++) {
    fill(0, 200 - insertion.get(i), 0);
    int size = (int) (maxSize * ((float) insertion.get(i) / 100f)); 
    int x = OFFSET + maxSize / 2 + ((i - start) % COLS) * maxSize;
    int y = OFFSET + maxSize / 2 + ((i - start) / COLS) * maxSize;
    
    ellipse(x, y, size, size);
  }
  
  if ( state * SIZE < insertion.size() - SIZE) {
      state++;
  }
  delay(40);
}

void saveState(ArrayList<Integer> list) {
  for (int i = 0; i < SIZE; i++) {
    list.add(numbers[i]);
  }
}

void selectionSort() {
  for (int i = 0; i < numbers.length; i++) {
    saveState(selection);
    
    int lowest = i;
    for (int j = i + 1; j < numbers.length; j++) {
      if (numbers[j] < numbers[lowest]) {
        lowest = j;
      }
    }
    int temp = numbers[i];
    numbers[i] = numbers[lowest];
    numbers[lowest] = temp;
    
  }
}

void insertionSort() {
  for (int i = 1; i < numbers.length; i++) {
    
    int j = i;
    while (j > 0 && numbers[j] < numbers[j - 1]) {
      int temp = numbers[j - 1];
      numbers[j - 1] = numbers[j];
      numbers[j] = temp;
      j--;
    }
    saveState(insertion);
  }
}