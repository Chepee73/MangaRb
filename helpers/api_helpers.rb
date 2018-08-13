API_ENDPOINT = '/api/v1/'

def join_url(url)
  API_ENDPOINT.split('/').push(split_and_remove(url)).join('/')
end

private
  def remove_empty(str)
    str.reject { |s| s.empty? }
  end

  def split_and_remove(str)
    remove_empty(str.split('/'))
  end
