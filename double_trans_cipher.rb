module DoubleTranspositionCipher
  def self.__get_mat_shape(tar)
    cols = Math.sqrt(tar).ceil
    rows, carry = tar.divmod(cols)
    rows += 1 if carry > 0
    [rows, cols]
  end

  def self.__gen_rand_map(mat_shp, rng)
    ret = []
    mat_shp.map do |sz|
      org = [*0...sz]
      ret = nil
      loop do
        ret = org.shuffle(random: rng)
        break if sz < 2 || ret != org
      end
      ret
    end
  end

  def self.__get_chunk(str, chk_sz, org_mat)
    cur_idx = 0
    str.each_char do |c|
      org_mat[cur_idx] << c
      cur_idx += 1 if org_mat[cur_idx].length == chk_sz
    end
  end

  def self.__trans_enc(row_map, col_map, org_mat, tran_mat)
    row_map.each_with_index do |x, i|
      col_map.each_with_index do |y, j|
        tran_mat[i][j] = org_mat[x][y]
      end
    end
  end

  def self.__trans_dec(row_map, col_map, org_mat, tran_mat)
    row_map.each_with_index do |x, i|
      col_map.each_with_index do |y, j|
        tran_mat[x][y] = org_mat[i][j]
      end
    end
  end

  def self.__remap(pln_txt, mat_shp, key, revert = false)
    org_mat = Array.new(mat_shp[0]) { '' }
    tran_mat = Array.new(mat_shp[0]) { Array.new(mat_shp[1]) }
    # generate random mappings using key as seed
    row_map, col_map = __gen_rand_map(mat_shp, Random.new(key))
    # break plaintext into evenly sized substring
    __get_chunk(pln_txt, mat_shp[1], org_mat)
    # swap rows and columns according to generated mappings
    if revert
      __trans_enc(row_map, col_map, org_mat, tran_mat)
    else
      __trans_dec(row_map, col_map, org_mat, tran_mat)
    end
    tran_mat.join
  end

  def self.encrypt(document, key)
    # turn object into string
    pln_txt = document.to_s
    # find number of rows/cols such that matrix is almost square
    mat_shp = __get_mat_shape(pln_txt.length)
    # pad original text
    pln_txt << 0.chr * (mat_shp[0] * mat_shp[1] - pln_txt.length)
    # encrypt
    __remap(pln_txt, mat_shp, key)
  end

  def self.decrypt(ciphertext, key)
    mat_shp = __get_mat_shape(ciphertext.length)
    __remap(ciphertext, mat_shp, key, true).tr(0.chr, '')
  end
end
