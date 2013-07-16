package org.myorg;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URI;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.apache.hadoop.util.Progressable;

public class FileCopyWithProgress {

	public static void main(String[] args) throws IOException {
		InputStream in = null;
		OutputStream out = null;
		try {
			String from = args[0];
			String to = args[1];
			Configuration conf = new Configuration();
			FileSystem fs = FileSystem.get(URI.create(to), conf);
			Progressable progress = new Progressable() {
				@Override
				public void progress() {
					System.out.println("*");
				}
			};
			in = fs.open(new Path(from));
			out = fs.create(new Path(to), progress);
			IOUtils.copyBytes(in, out, conf);
			System.out.println("copying finished");
		} finally {
			if (in != null) {
				in.close();	
			}
			if (out != null) {
				out.close();
			}
		}
	}
	
}
