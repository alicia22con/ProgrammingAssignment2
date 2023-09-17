## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {

}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
}


# Create a special matrix object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  # Initialize an empty cache
  cache <- NULL
  
  # Set a function to set the matrix and cache its inverse
  set <- function(matrix) {
    x <<- matrix  # Assign the matrix to the special 'x' object
    cache <<- NULL  # Clear the cache
  }
  
  # Set a function to get the matrix
  get <- function() {
    x  # Return the matrix
  }
  
  # Set a function to cache the inverse of the matrix
  cache_inverse <- function() {
    if (!is.null(cache)) {
      message("Getting cached result.")
      return(cache)  # If cached, return the cached inverse
    }
    
    message("Calculating and caching the inverse.")
    cache <- solve(x)  # Calculate and store the inverse in the cache
    return(cache)
  }
  
  # Return a list of functions to manipulate the matrix
  list(set = set, get = get, cache_inverse = cache_inverse)
}

# Compute the inverse of the cached matrix
cacheSolve <- function(cache) {
  if (!is.function(cache$cache_inverse)) {
    stop("The 'cache' object must be created using 'makeCacheMatrix'.")
  }
  
  return(cache$cache_inverse())
}

# Create a cacheable matrix
mat_cache <- makeCacheMatrix(matrix(c(1, 2, 3, 4), nrow = 2))

# Get the matrix
mat <- mat_cache$get()
print(mat)

# Compute the inverse (it will cache the result)
inverse <- cacheSolve(mat_cache)
print(inverse)

# Retrieve the cached inverse (no recalculation)
cached_inverse <- cacheSolve(mat_cache)
print(cached_inverse)

