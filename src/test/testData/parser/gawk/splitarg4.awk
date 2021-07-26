BEGIN { 
  split("c: ::ab+", fs_arr, ":") 
}
{
  for (i = 1; i in fs_arr; ++i) {
    split($0, a, fs_arr[i], seps)
    print zipcat(a, seps)
    dump_array(seps)
  }
}
END { 
  seps[1] = "123"; seps[5] = 10
  for (i = 1; i in fs_arr; ++i) {
    split("", a, fs_arr[i], seps)
    dump_array(seps)
  }
}
function dump_array(a,   i, mini, maxi)
{
  mini = minidx(a) + 0
  maxi = maxidx(a) + 0
  printf "{"
  for (i = mini; i <= maxi; ++i)
    if (i in a) {
      if (i > mini)
        printf ", "
      printf "%d => \"%s\"", i, a[i]
    }
  printf "}\n"
}
function zipcat(a, b,   c)
{
  zip(a, b, c)
  return cat(c)
}

function cat(a,   mini, maxi, i, s)
{
  mini = minidx(a) + 0
  maxi = maxidx(a) + 0
  for (i = mini; i <= maxi; ++i)
    if (i in a)
      s = s a[i]
  return s
}

function zip(a, b, c,   mini, maxi, i)
{
  del(c)
  mini = minidx2(a, b) + 0
  maxi = maxidx2(a, b) + 0
  for (i = mini; i <= maxi; ++i) {
    if (i in a)
      c[i] = a[i]
    if (i in b)
      c[i] = c[i] b[i]
  }
}

function maxidx2(a, b)
{
  if (emptyarr(a))
    return maxidx(b)
  else if (emptyarr(b))
    return maxidx(a)
  else
    return max(maxidx(a), maxidx(b))
}

function minidx2(a, b)
{
  if (emptyarr(a))
    return minidx(b)
  else if (emptyarr(b))
    return minidx(a)
  else
    return min(minidx(a), minidx(b))
}

function maxidx(a,   i, m)
{
  if (emptyarr(a))
    m = ""
  else {
    m = choose(a) + 0
    for (i in a) {
      i += 0
      if (i > m)
        m = i
    }
  }
  return m
}

function minidx(a,   i, m)
{
  if (emptyarr(a))
    m = ""
  else {
    m = choose(a) + 0
    for (i in a) {
      i += 0
      if (i < m)
        m = i
    }
  }
  return m
}

function choose(a,   m)
{
  for (m in a)
    return m
  return ""
}

function emptyarr(a,  k)
{
  for (k in a)
    return 0
  return 1
}

# portable delete
function del(a)
{
  split("", a)
}

function max(x, y)
{
  return x > y ? x : y
}

function min(x, y)
{
  return x < y ? x : y
} 
