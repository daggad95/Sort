import java.util.Arrays;

int[] numbers;
ArrayList<Integer> selection;
ArrayList<Integer> insertion;
ArrayList<Integer> merge;
ArrayList<Integer> quick;
ArrayList<Integer> sortArray;
int COLS = 25;
int OFFSET = 100;
int SIZE = 500;
int MIN = 5;
int MAXSPEED = 200;
int spacing;
int state;
float delay; //steps per second
boolean reversing;

void setup() {
  selection = new ArrayList<Integer>(); 
  insertion = new ArrayList<Integer>();
  merge = new ArrayList<Integer>();
  quick = new ArrayList<Integer>();
  delay = 10;
  reversing = false;
  
  size(900, 900);
}

void draw() {
  background(0);
  
  textSize(32);
  fill(255);
  text("Delay: " + delay, 10, 30);
  
  //drawing array
  if (sortArray != null) {
    int start = state * SIZE;
    int end = start + SIZE;
    spacing = (width - OFFSET * 2) / COLS;
    
    for (int i = start; i < end; i++) {
      float heat = 255 * ((float) state / (sortArray.size() / SIZE);
      fill(heat, 255 - sortArray.get(i) / 2, heat);
      int size = (int) (MIN + sortArray.get(i) * ((float) (spacing - MIN) / SIZE)); 
      int x = OFFSET + ((i - start) % COLS) * spacing;
      int y = OFFSET + ((i - start) / COLS) * spacing;
      
      ellipse(x, y, size, size);
    }
    
    if (reversing) {
     if (state > 0) {
        state--;
        delay((int) delay);
      }
    } else {
      if (state * SIZE < sortArray.size() - SIZE) {
        state++;
        delay((int) delay);
      } 
    }
  }
}

void saveState(ArrayList<Integer> list) {
  for (int i = 0; i < SIZE; i++) {
    list.add(numbers[i]);
  }
}

int[] genArray() {
  ArrayList<Integer> list = new ArrayList<Integer>();
  int nums[] = new int[SIZE];
  
  int i;
  for (i = 0; i < SIZE; i++) {
    list.add(i);
  }
  
  i = 0;
  while (list.size() > 0) {
    int idx = (int) random(list.size());
    nums[i] = list.get(idx);
    list.remove(idx);
    i++;
  }
  
  return nums;
}

//////////////USER INPUT/////////////////////
void keyTyped() {
  //sorting
  if (key == '1') {
    numbers = genArray();
    selectionSort();
    sortArray = selection;
    state = 0;
    
  } else if (key == '2') {
    numbers = genArray();
    insertionSort();
    sortArray = insertion;
    state = 0;
  } else if (key =='3') {
    numbers = genArray();
    mergeSort();
    sortArray = merge;
    state = 0;
  } else if (key == '4') {
    numbers = genArray();
    quickSort();
    sortArray = quick;
    state = 0;
  }else if (key ==' ') {
    reversing = !reversing;
  }
  

  if (key == 'w') {
    delay += 10;
  } else if (key == 's' && delay > 1) {
    delay -= 10;
  } 
}


////////////////SORTS////////////////////////
void selectionSort() {
  selection.clear();
  reversing = false;
  
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
  insertion.clear();
  reversing = false;
  
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

void mergeSort() {
  merge.clear();
  reversing = false;
  mergeRecurse(0, numbers.length - 1);
}

void mergeRecurse(int start, int end) {
  if (start < end) {
    int mid = (int) Math.floor((start + end) / 2);
    
    mergeRecurse(start, mid);
    mergeRecurse(mid + 1, end);
    merge(start, end, mid);
    saveState(merge);
  }
}

void merge(int start, int end, int mid) {
  int i = 0; 
  int j = 0;
  
  int[] left = new int[mid + 1 - start];
  int[] right = new int[end - mid];
  
  System.arraycopy(numbers, start, left, 0, left.length);
  if (j <= end) {
    System.arraycopy(numbers, mid + 1, right, 0, right.length);
  }
  
  int idx = start;
  while (i < left.length && j < right.length) {
    if (left[i] < right[j]) {
      numbers[idx] = left[i];
      i++;
    } else {
      numbers[idx] = right[j];
      j++;
    }
    idx++;
  }
  
  while (i < left.length) {
    numbers[idx] = left[i];
    i++;
    idx++;
  }
  
  while (j < right.length) {
    numbers[idx] = right[j];
    j++;
    idx++;
  }
}

void quickSort() {
  quick.clear();
  reversing = false;
  quickRecurse(0, numbers.length - 1);
}

void quickRecurse(int start, int end) {
  if (start < end) {
    int mid = (int) Math.floor((start + end) / 2);
    
    int q = partition(start, end);
    quickRecurse(start, q - 1);
    quickRecurse(q + 1, end);
  }
}

int partition(int start, int end) {
  int i = start;
  int j = start;
  int pivot = numbers[end];
  
  while (j < end) {
    if (numbers[j] < pivot) {
      int temp = numbers[i];
      numbers[i] = numbers[j];
      numbers[j] = temp;
      i++;
    }
    j++;
  }
  
  int temp = numbers[i];
  numbers[i] = numbers[end];
  numbers[end] = temp;
  saveState(quick);
  
  return i;
}